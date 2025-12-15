module FlashMessages
  module ControllerHelpers
    extend ActiveSupport::Concern
    
    def flash_and_redirect(type, message, path, width: 448)
      flash[type] = { message: message, width: width }
      redirect_to path
    end
    
    def flash_and_render(type, message, template, width: 448, status: :unprocessable_entity)
      flash.now[type] = { message: message, width: width }
      render template, status: status
    end
    
    def flash_turbo_stream(type, message, width: 448, duration: 5000)
      turbo_stream.append(
        "flash-messages",
        partial: "flash_messages/flash_message",
        locals: { 
          type: type, 
          message: message,
          width_px: width,
          duration: duration
        }
      )
    end
    
    def flash_response(success:, success_message:, error_message:, success_path: nil, error_template: nil, turbo_success: nil, turbo_error: nil, success_width: 384, error_width: 672)
      if success
        respond_to do |format|
          format.html do
            flash[:success] = { message: success_message, width: success_width }
            redirect_to success_path if success_path
          end
          
          format.turbo_stream do
            if turbo_success
              turbo_success.call
            else
              render turbo_stream: flash_turbo_stream(:success, success_message, width: success_width)
            end
          end
        end
      else
        respond_to do |format|
          format.html do
            flash.now[:error] = { message: error_message, width: error_width }
            render error_template, status: :unprocessable_entity if error_template
          end
          
          format.turbo_stream do
            if turbo_error
              turbo_error.call
            else
              render turbo_stream: flash_turbo_stream(:error, error_message, width: error_width)
            end
          end
        end
      end
    end
  end
end
