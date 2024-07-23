class GeneratedImagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @generated_image = current_user.generated_images.find(params[:id])

    @generated_image.broadcast_to_main_image

    respond_to do |format|
      format.html { head :ok }
    end
  end

  def destroy
    @generated_image = current_user.generated_images.find(params[:id])
    @generated_image.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@generated_image), notice: "Generated image was successfully destroyed." }
    end
  end
end
