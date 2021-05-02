# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe '/stylists', type: :request do

  let(:valid_attributes) do
    # attributes_for(:stylist)
    { test: 'test' }
  end

  # let(:invalid_attributes) do
  #   attributes_for(:invalid_stylist, rank_id: ranks.id)
  # end

  # let(:valid_headers) do
  #   { 'ACCEPT': 'application/json' }
  # end

  describe 'GET /index' do
    p valid_attributes
    it 'renders a successful response' do
      Stylist.create! valid_attributes
      get api_v1_stylists_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      stylist = Stylist.create! valid_attributes
      get stylist_url(stylist), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      p valid_attributes
      p ranks
      p invalid_attributes
      it 'creates a new Stylist' do
        expect do
          post stylists_url,
               params: { stylist: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Stylist, :count).by(1)
      end

      it 'renders a JSON response with the new stylist' do
        post stylists_url,
             params: { stylist: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Stylist' do
        expect do
          post stylists_url,
               params: { stylist: invalid_attributes }, as: :json
        end.to change(Stylist, :count).by(0)
      end

      it 'renders a JSON response with errors for the new stylist' do
        post stylists_url,
             params: { stylist: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested stylist' do
        stylist = Stylist.create! valid_attributes
        patch stylist_url(stylist),
              params: { stylist: new_attributes }, headers: valid_headers, as: :json
        stylist.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the stylist' do
        stylist = Stylist.create! valid_attributes
        patch stylist_url(stylist),
              params: { stylist: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the stylist' do
        stylist = Stylist.create! valid_attributes
        patch stylist_url(stylist),
              params: { stylist: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested stylist' do
      stylist = Stylist.create! valid_attributes
      expect do
        delete stylist_url(stylist), headers: valid_headers, as: :json
      end.to change(Stylist, :count).by(-1)
    end
  end
end
