class MutantsController < ApplicationController
  def check_dna
    return render json: {}, status: :ok if DnaChecker.new.is_mutant?(params[:dna])
    render json: {}, status: :forbidden
  rescue DnaCheckerErrors::Standard => e
    render json: { error: e.message }, status: :bad_request
  end
end
