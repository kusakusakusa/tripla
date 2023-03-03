json.friends do
  json.array! @current_user.friends_rankings.map do |user_id|
    json.merge! @friends_hash[user_id].first.attributes
    json.sleep_logs do
      json.array! @logs[user_id]
    end
  end
end