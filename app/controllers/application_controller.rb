class ApplicationController < ActionController::Base
  def hello
    render html: "¡Hola, mundo!"
  end

  def goodbye
    render :json => {
      message: 'goodbye, world!'
    }
  end
end
