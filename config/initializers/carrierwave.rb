CarrierWave.configure do |config|
  config.storage             = :qiniu
 config.qiniu_access_key    = ENV["5xpEUZGlcY5HwJpvyZu0ISxLy0y4ihGsllLsKvH3"]
 config.qiniu_secret_key    = ENV["TVefJ--ZULnMFjjXPLsCMI6n8rIitgUj7UivEZk5"]
 config.qiniu_bucket        = ENV["jd-stroe"]
 config.qiniu_bucket_domain = ENV["https://portal.qiniu.com/cdn/domain/ql2av6kts.hn-bkt.clouddn.com"]
 config.qiniu_block_size    = 4*1024*1024
 config.qiniu_protocol      = "http"
 config.qiniu_up_host       = "http://portal.qiniu.com"  #选择不同的区域时，"up.qiniu.com" 不同
end
