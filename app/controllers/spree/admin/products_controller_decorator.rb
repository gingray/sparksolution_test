Spree::Admin::ProductsController.class_eval do
  def import_csv
    puts import_csv_params
    redirect_to import_admin_products_path, success: 'import started'
  end

  private
  def import_csv_params
    params.permit(:import_csv)
  end
end