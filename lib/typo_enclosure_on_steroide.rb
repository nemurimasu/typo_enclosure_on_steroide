# TypoEnclosureOnSteroide
module TypoEnclosureOnSteroide
  
end

module TypoEnclosureOnSteroideHelper
  
  def display_mp3(filename, has_ogg)
    html = "<li><p>Download: "
    html << "<a href=\"#{this_blog.base_url}/files/#{filename}.mp3\">#{filename}.mp3</a>"
    html << " <a href=\"#{this_blog.base_url}/files/#{filename}.ogg\">#{filename}.ogg</a>" if has_ogg
    html << "</p>"
    html << "<audio controls>"
    html << "<source src=\"#{this_blog.base_url}/files/#{filename}.mp3\" type=\"audio/mpeg\" />"
    html << "<source src=\"#{this_blog.base_url}/files/#{filename}.ogg\" type=\"audio/ogg\" />" if has_ogg
    html << "<object type='application/x-shockwave-flash' data='#{this_blog.base_url}/dewplayer.swf?mp3=#{this_blog.base_url}/files/#{filename}' width='200' height='20'>"
    html << "<param name='movie' value='#{this_blog.base_url}/dewplayer.swf?mp3=#{this_blog.base_url}/files/#{filename}' />"
    html << "</object></audio></li>"
  end

  def display_ogg(filename)
    html = "<li><audio controls>"
    html << "<source src=\"#{this_blog.base_url}/files/#{filename}.ogg\" type=\"audio/ogg\" />"
    html << "</audio></li>"
  end
  
  def display_simple_file(filename)
    html = "<li>"
    html << "Download: "
    html << link_to(filename, "#{this_blog.base_url}/files/#{filename}")
    html << "</li>"
  end
  
  def display_resources(article)
    return if article.resources.size == 0
    
    html = "<h3>Attachments</h3>"
    html << "<ul>"
    
    mp3s = []
    oggs = []
    others = []
    article.resources.each do |resource|
      case File.extname(resource.filename)
        when ".mp3"; mp3s << resource.filename.chomp(".mp3")
        when ".ogg"; oggs << resource.filename.chomp(".ogg")
        else; others << resource.filename
      end
    end
    mp3s.each do |mp3|
      html << display_mp3(mp3, oggs.include?(mp3))
    end
    oggs.each do |ogg|
      html << display_ogg(ogg) unless mp3s.include? ogg
    end
    others.each do |other|
      html << display_simple_file(resource.filename)
    end
    
    html << "</ul>"
    
  end
end
