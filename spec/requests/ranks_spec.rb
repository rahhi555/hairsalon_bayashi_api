# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe '/ranks', type: :request do

  let(:valid_attributes) do
    attributes_for(:rank)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_rank)
  end

  let(:valid_headers) do
    { 'ACCEPT': 'application/json' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Rank.create! valid_attributes
      get api_v1_ranks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      rank = Rank.create! valid_attributes
      get api_v1_rank_url(rank), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Rank' do
        expect do
          post api_v1_ranks_url,
               params: { rank: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Rank, :count).by(1)
      end

      it 'renders a JSON response with the new rank' do
        post api_v1_ranks_url,
             params: { rank: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Rank' do
        expect do
          post api_v1_ranks_url,
               params: { rank: invalid_attributes }, as: :json
        end.to change(Rank, :count).by(0)
      end

      it 'renders a JSON response with errors for the new rank' do
        post api_v1_ranks_url,
             params: { rank: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'B' } }

      it 'updates the requested rank' do
        rank = Rank.create! valid_attributes
        patch api_v1_rank_url(rank),
              params: { rank: new_attributes }, headers: valid_headers, as: :json
        rank.reload
        expect(rank.name).to eq new_attributes[:name]
      end

      it 'renders a JSON response with the rank' do
        rank = Rank.create! valid_attributes
        patch api_v1_rank_url(rank),
              params: { rank: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the rank' do
        rank = Rank.create! valid_attributes
        patch api_v1_rank_url(rank),
              params: { rank: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested rank' do
      rank = Rank.create! valid_attributes
      expect do
        delete api_v1_rank_url(rank), headers: valid_headers, as: :json
      end.to change(Rank, :count).by(-1)
    end
  end
end
