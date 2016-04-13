class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  before_action :set_digest_type
  before_action :initialize_subscriber, only: [:index, :show, :home]

  layout "digest"

  DOMAIN_TO_DIGEST = {
    "programmingdigest.net" => Weekly::Digest::PROGRAMMING,
    "photographydigest.net" => Weekly::Digest::PHOTOGRAPHY,
    "csharpdigest.net" => Weekly::Digest::CSHARP,
    "elixirdigest.net"=> Weekly::Digest::ELIXIR,
    "reactdigest.net" => Weekly::Digest::REACT
  }

  DIGEST_MAPPINGS = {
    Weekly::Digest::PROGRAMMING => { name: "Programming", analytics: "UA-66393277-1", twitter: "softwaredigest" },
    Weekly::Digest::PHOTOGRAPHY => { name: "Photography", analytics: "UA-66393277-2", twitter: "35mmdigest" },
    Weekly::Digest::CSHARP => { name: "C#", analytics: "UA-66393277-3", twitter: "csharpdigest" },
    Weekly::Digest::ELIXIR => { name: "Elixir", analytics: "UA-66393277-4", twitter: "elixirdigest" },
    Weekly::Digest::REACT => { name: "React", analytics: "UA-66393277-5", twitter: "reactjsdigest" }
  }

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

  def submission
    @submission = SubmissionForm.new(digest: @digest_type)
  end

  def send_submission
    @submission = SubmissionForm.new(params[:submission_form].permit([:name, :email, :url, :description, :digest, :nickname]))
    if @submission.valid?
      @submission.deliver
      flash[:success] = "Your link was sent to us"
      redirect_to :submit
    else
      render :submission
    end
  end

  def advertisement
    @advertisement = AdvertisementForm.new(digest: @digest_type)
  end

  def send_advertisement
    @advertisement = AdvertisementForm.new(params[:advertisement_form].permit([:company, :email, :questions, :url, :keywords, :description, :digest, :nickname]))
    if @advertisement.valid?
      @advertisement.deliver
      flash[:success] = "Your request was sent to us"
      redirect_to :advertise
    else
      render :advertisement
    end
  end

  def job_listing
    @job_listing = AdvertisementForm.new(digest: @digest_type)
  end

  def send_job_listing
    @job_listing = AdvertisementForm.new(params[:advertisement_form].permit([:company, :email, :questions, :url, :keywords, :description, :digest, :nickname]))
    if @job_listing.valid?
      @job_listing.deliver
      flash[:success] = "Your request was sent to us"
      redirect_to :job
    else
      render :job_listing
    end
  end

  def spam_policy
  end

  def privacy_policy
  end

  private
  def set_digest_type
    @digest_type = DOMAIN_TO_DIGEST[request.host] || Weekly::Digest::PROGRAMMING
  end

  def initialize_subscriber
    @subscriber = Subscriber.new(digest: @digest_type)
  end
end
