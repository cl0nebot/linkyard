module ApplicationHelper
 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def navigation_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def formatted_date(time)
    time.to_date.to_formatted_s(:long)
  end

  def tracking_id(digest_type)
    DigestsController::DIGEST_MAPPINGS[digest_type][:analytics]
  end

  def digest_name(digest_type)
    DigestsController::DIGEST_MAPPINGS[digest_type][:name]
  end

  def twitter_username(digest_type)
    DigestsController::DIGEST_MAPPINGS[digest_type][:twitter]
  end

  def other_digests(digest_type)
    DigestsController::DOMAIN_TO_DIGEST.reject { |k, v| v == digest_type || Weekly::Digest::INACTIVE_DIGESTS.include?(v) }
  end
end
