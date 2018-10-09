require 'rails_helper'
require 'shared_examples.rb'

describe 'Mutants', type: :request do
  include_context 'shared dna examples'
  let(:invalid_letters_response) do
    { 'error' => 'The entered dna contains invalid characters' }
  end

  let(:invalid_matrix_response) do
    { 'error' => 'The entered dna is not square (NxN)' }
  end

  let(:matrix_required_error) do
    { 'error' => 'A matrix is required' }
  end

  let(:mutant_verified_response) do
    { 'result' => 'Mutant verified' }
  end

  let(:mutant_not_verified_response) do
    { "result" => "Not a mutant" }
  end

  describe '/mutant' do
    context 'when the dna is not square' do
      it 'returns 400 bad request' do
        post '/mutant', params: { 'dna': non_square_dna}
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq(invalid_matrix_response)
      end
    end

    context 'when the dna contains invalid characters' do
      it 'returns 400 bad request' do
        post '/mutant', params: { 'dna': invalid_letters_dna}
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq(invalid_letters_response)
      end
    end

    context 'when no dna is sent' do
      it 'returns 400 bad request' do
        post '/mutant'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq(matrix_required_error)
      end
    end

    context 'when the dna contains mutant patters' do
      it 'returns 200 ok' do
        post '/mutant', params: { 'dna': mutant_dna }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(mutant_verified_response)
      end
    end

    context 'when the entered dna is not mutant' do
      it 'returns 403 forbidden' do
        post '/mutant', params: { 'dna': non_mutant_dna }
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)).to eq(mutant_not_verified_response)
      end
    end
  end
end
