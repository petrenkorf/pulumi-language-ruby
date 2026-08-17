require 'ruby_pulumi/pulumi'

# Register all buckets first: each `CustomResource.new` fires its
# RegisterResource RPC without blocking. Reading outputs is deferred to the
# loop below, so the RPCs overlap in flight instead of resolving one at a
# time.
buckets = 40.times.map do |i|
  Pulumi::CustomResource.new(
    'aws:s3/bucket:Bucket',
    "my-bucket-#{i}",
    props: {
      'forceDestroy' => true
    }
  )
end

buckets.each do |bucket|
  puts "Registered #{bucket.urn} -> #{bucket['bucket']}"
end
