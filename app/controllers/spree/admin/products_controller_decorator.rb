Spree::Admin::ProductsController.class_eval do
  def import_csv
    msg, err = ImportProductProcessor.call params[:import_csv].tempfile
    if err
      redirect_to import_admin_products_path, flash: { error: err }
    else
      redirect_to import_admin_products_path, flash: { success: msg }
    end
  end

  private

  def import_csv_params
    params.permit(:import_csv)
  end
end