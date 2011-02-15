module Feeder
  
  class Parser
                
    def initialize
      seed_data if Post.all.empty?
      Feed.all.each do |feed|
        feed.update_attributes(:raw => Base64.encode64(Marshal.dump(Feedzirra::Feed.fetch_and_parse(feed.url))), :updates => false)
      end
    end
    
    def perform
      Feed.all.each do |feed|
        raw = Marshal.load(Base64.decode64(feed.raw))
        feed.update_attribute(:updates, true) unless Feedzirra::Feed.update(raw).new_entries.empty?
      end
      puts "i was here!"
      parse    
    end
    
    def async
        Resque.enqueue(Worker)
    end
    
    
    protected
    
    def parse
      sources.each do |source|
          source.updates ? feed = Feedzirra::Feed.update(Marshal.load(Base64.decode64(source.raw))) : feed = Feedzirra::Feed.fetch_and_parse(source.url)
          eval(feed,source.id,source.updates,source.url) unless feed.eql?(404)
      end
    end
    

    def sources
       Feed.find_all_by_updates(true) 
    end
    
    def seed_data
      Feed.all.each do |feed|
        raw_feed = Feedzirra::Feed.fetch_and_parse(feed.url)
        if !feed.eql?(404)
          raw_feed.entries.each do |entry|
            populate_record(entry,feed.id)
          end
        end
      end
    end
    
    def eval(feed,id,updates,url)
      if updates
        feed.new_entries.each do |entry|
          populate_record(entry,id)
        end
      else
        feed.entries.each do |entry|
          populate_record(entry,id)
        end
      end
      Feed.find(id).update_attributes(:raw => Base64.encode64(Marshal.dump(Feedzirra::Feed.fetch_and_parse(feed.url))), :updates => false)
    end
    
    def populate_record(entry,id)
        post = Post.create(:title => (entry.title.sanitize unless entry.title.nil?), :url => (entry.url unless entry.url.nil?), :published => (entry.published unless entry.published.nil?),
         :content => (entry.content.sanitize unless entry.content.nil?), :feed_id => id, :summary => (entry.summary unless entry.summary.nil?), :author => (entry.author.sanitize unless entry.author.nil?))
         post.update_attribute(:published , Time.now)
         puts "Post created for #{Feed.find(id).url}" 
    end 
    
  end
  
end