class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  before_action :set_digest_type
  before_action :initialize_subscriber, only: [:index, :show, :home]

  layout "digest"

  def index
    @digests = Weekly::Digest.all(@digest_type).reverse
  end

  def show
    return unless Weekly::Digest.valid_issue?(@digest_type, params[:id].to_i)

    @digest = Weekly::Digest.new(@digest_type, issue: params[:id].to_i)
  end

  def search
    @links = LinkSearch.new(params[:search], Link.digestable(@digest_type)).call if params[:search].present?
   end

  def feed
    @digests = Weekly::Digest.take(@digest_type, 10).reverse
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def home
    @latest_issue = Weekly::Digest.issue_from(@digest_type, Time.zone.now)
  end

  def contact
    @contact = ContactForm.new(digest: @digest_type)
  end

  def send_contact
    @contact = ContactForm.new(params[:contact_form].permit([:name, :email, :message, :digest, :nickname]))
    if @contact.valid?
      @contact.deliver
      flash[:success] = "Your message was sent to us."
      redirect_to :contact
    else
      render :contact
    end
  end

  private
  def set_digest_type
    @digest_type = case request.host
    when "programmingdigest.net"
      Weekly::Digest::PROGRAMMING
    when "photographydigest.net"
      Weekly::Digest::PHOTOGRAPHY
    when "csharpdigest.net"
      Weekly::Digest::CSHARP
    when "elixirdigest.net"
      Weekly::Digest::ELIXIR
    when "reactdigest.net"
      Weekly::Digest::REACT
    when "localhost"
      Weekly::Digest::PROGRAMMING
    else
      raise "Domain #{request.host} is not supported for digests"
    end
  end

  def initialize_subscriber
    @subscriber = Subscriber.new(digest: @digest_type)
  end
end
