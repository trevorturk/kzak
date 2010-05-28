xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title CONFIG['app_name']
    xml.link CONFIG['domain']
    for feed_item in @feed_items
      xml.item do
        xml.title feed_item.post.to_s
        xml.author(feed_item.post.user)
        xml.pubDate feed_item.post.created_at.utc.to_s(:rfc822)
        xml.link CONFIG['domain']
        xml.guid "#{CONFIG['domain']}?mp3=#{File.basename(feed_item.post.mp3.to_s)}"
      end
    end
  end if @feed_items
end