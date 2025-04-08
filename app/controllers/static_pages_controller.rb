class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end
  
  def contact
  end

  def terms
    file_path = Rails.root.join('app/assets/terms/psycho-logic_terms.txt')
    @terms_text = File.read(file_path, encoding: 'UTF-8')
  end
end
