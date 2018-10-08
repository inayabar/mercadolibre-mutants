class MutantsController < ApplicationController
  def check_dna
    return render json: { error: 'A matrix is required' }, status: :bad_request if params[:dna].blank?
    return render json: { result: 'Mutant verified' }, status: :ok if DnaChecker.new.is_mutant?(params[:dna])
    render json: { result: 'Not a mutant' }, status: :forbidden
  rescue DnaCheckerErrors::Standard => e
    render json: { error: e.message }, status: :bad_request
  end
end
