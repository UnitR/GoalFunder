require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary files
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")        # permanent uploads
}

# Configure for ActiveRecord
Shrine.plugin :activerecord

# Retain cached files during form redisplays
Shrine.plugin :cached_attachment_data

# Keep metadata when attaching a cached file
Shrine.plugin :restore_cached_data

# Prettify image location hierarchy
Shrine.plugin :pretty_location