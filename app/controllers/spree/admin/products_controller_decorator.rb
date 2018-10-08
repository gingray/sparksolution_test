Spree::Admin::ProductsController.class_eval do
  def import_csv
    ImportProductProcessor.call params[:import_csv].tempfile
    redirect_to import_admin_products_path, flash: { success: I18n.t('import_products.success') }
  end

  private

  def import_csv_params
    params.permit(:import_csv)
  end
end