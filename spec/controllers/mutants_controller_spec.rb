require 'rails_helper'
require 'shared_examples.rb'

describe MutantsController, :type => :controller do
  include_context "shared dna examples"
  describe 'check_dna' do
    context 'when the dna is not square' do
      it 'returns 400 bad request' do
        post '/mutant', body: { 'dna': non_square_dna}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
