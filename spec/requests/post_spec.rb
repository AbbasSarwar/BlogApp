require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /all' do
    it 'returns http success' do
      get '/post/all'
      expect(response).to have_http_status(:success)
    end
  end
end
