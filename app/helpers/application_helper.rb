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
    case digest_type
    when Weekly::Digest::PHOTOGRAPHY
      "UA-66393277-2"
    when Weekly::Digest::CSHARP
      "UA-66393277-3"
    when Weekly::Digest::ELIXIR
      "UA-66393277-4"
    when Weekly::Digest::REACT
      "UA-66393277-5"
    else
      "UA-66393277-1"
    end
  end

  def digest_name(type)
    case type
    when Weekly::Digest::CSHARP
      "C#"
    else
      type.capitalize
    end
  end

  def twitter_username(digest_type)
    case digest_type
    when Weekly::Digest::PHOTOGRAPHY
      "35mmdigest"
    when Weekly::Digest::CSHARP
      "csharpdigest"
    when Weekly::Digest::ELIXIR
      "elixirdigest"
    when Weekly::Digest::REACT
      "reactjsdigest"
    else
      "softwaredigest"
    end
  end
end
