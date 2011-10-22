# TypoEnclosureOnSteroide
module TypoEnclosureOnSteroide
  
end

module TypoEnclosureOnSteroideHelper
  
  def display_mp3(filename, has_ogg)
    html = "<li><audio controls>"
    html << "<source src=\"/files/#{filename}.mp3\" type=\"audio/mpeg\" />"
    html << "<source src=\"/files/#{filename}.ogg\" type=\"audio/ogg\" />" if has_ogg
    html << "<object type='application/x-shockwave-flash' data='/dewplayer.swf?mp3=/files/#{filename}' width='200' height='20'>"
    html << "<param name='movie' value='/dewplayer.swf?mp3=/files/#{filename}' />"
    html << "</object></audio></li>"
  end

  def display_ogg(filename)
    html = "<li><audio controls>"
    html << "<source src=\"/files/#{filename}.ogg\" type=\"audio/ogg\" />"
    html << "</audio></li>"
  end
  
  def display_simple_file(filename)
    html = "<li>"
    html << link_to(filename, "/files/#{filename}")
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
