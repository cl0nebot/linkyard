class Reddit::Identity < Reddit::Response  
  reddit_reader [:name, "name"]
  reddit_reader [:created, "created"]
  reddit_reader [:gold_credits, "gold_creddits"]
  reddit_reader [:created_utc, "created_utc"]
  reddit_reader [:link_karma, "link_karma"]
  reddit_reader [:comment_karma, "comment_karma"]
  reddit_reader [:over_18, "over_18"]
  reddit_reader [:is_gold, "is_gold"]
  reddit_reader [:is_mod, "is_mod"]
  reddit_reader [:has_verified_email, "has_verified_email"]
  reddit_reader [:id, "id"]
end
