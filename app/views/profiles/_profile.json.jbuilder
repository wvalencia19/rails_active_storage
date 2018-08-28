json.extract! profile, :id, :name, :description, :twitter_account, :created_at, :updated_at
json.url profile_url(profile, format: :json)
