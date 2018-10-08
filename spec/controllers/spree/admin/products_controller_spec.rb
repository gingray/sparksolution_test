describe Spree::Admin::ProductsController do
  let(:user) { create :admin_user }
  context '#import' do
    before { sign_in(user) }
    before { get :import }
    it do
      expect(response).to have_http_status(:success)
    end
  end

  context '#import_csv', focus: true do
    let(:file) { fixture_file_upload('/sample.csv', 'text/csv') }
    before { sign_in(user) }

    before { post :import_csv, params: { import_csv: file } }
    it do
      expect(response).to have_http_status(:success)
    end
  end
end