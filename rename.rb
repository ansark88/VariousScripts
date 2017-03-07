#!/usr/bin/ruby
#画像保存時に拡張子に余計な文字がついたり、名称の重複に困ったのでリネームスクリプトを作成。
#imglist.eachを何回もやっているので無駄が多い。

imglist = Dir.glob("*.*")

imglist.each do |f|
  if /(img|large)[ \(\)]+/ =~ f
    newfile = f.gsub(/[ \(\)]+/,"0")
    File.rename(f,newfile) 
    puts "#{f}:rename done, #{newfile}"
   elsif /(img\.)[php.*$]+/ =~ f
    newfile = f.gsub(/img\.php(.+)$/,"img\\1\.jpg") #gsubメソッドは\1ではなく\1にする必要がある
    File.rename(f,newfile) 
    puts "#{f}:rename done, #{newfile}"
  end
end

imglist.each do |f|
  if /\.(jpe?g|png)_[0-9]+/ =~ f
    newfile = f.gsub(/_[0-9]+$/,"")
    File.rename(f,newfile) 
  end
end

imglist.each do |f|
  if /\.(php-image.+)/ =~ f
    newfile = f.gsub(/php-image.+/,"jpg")
    File.rename(f,newfile) 
  end
end


imglist.each do |f|
  if /\.(jpg-large)/ =~ f
    newfile = f.gsub(/jpg-large$/,"jpg")
    File.rename(f,newfile) 
  end
end

imglist.each do |f|
  if /\.(png-large)/ =~ f
    newfile = f.gsub(/png-large$/,"png")
    File.rename(f,newfile) 
  end
end

#rename本体
imglist.each do |f|
  if /((\d)+|large(-[0-9]+)?|resize_image.*)(\.(jpg|jpeg|jpg-large|png|php-image.*|gif))/ =~ f
    reg = $+
    
    t = Time.new
    t = File.ctime(f)
    
    newfilename = t.strftime("%Y%m%d%H%M%S")
    filesize = File.size?(f)  #ファイルサイズを足す
    
    newfilename = newfilename.to_i + filesize
  
    newfile = newfilename.to_s + "." + reg
    
    unless  File.exist?(newfile)
       File.rename(f,newfile)
	     puts "#{f}:rename done, #{newfile}"
    else 
       puts "#{newfile} is existing!!"
    end
  end
end
