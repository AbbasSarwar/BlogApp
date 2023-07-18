require 'rails_helper'

RSpec.describe 'Routing Requests', type: :request do
  describe 'Status & Rendering & correct placeholder for Users' do
    it 'Root / ' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('All Users')
    end

    it 'Status User users/:id' do
      get '/users/56'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('User Found By ID')
    end
  end
end