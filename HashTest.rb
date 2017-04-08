# ハッシュの練習

def outputtxt(keyname,myhash)
  data = myhash[keyname]
  puts "#{keyname},#{data}"
end

path = ARGV[0]
if ARGV[0] == nil
  path = "~/text.txt"
end

hhash = {}
path = File::expand_path(path) #絶対パスを返す

File.open(path,"r") do |file|
  file.each do |s|
    if (s =~ /^[0-9]/)
      tmp = s.split(" ")
      hhash.store(tmp[0],tmp[1])
    elsif ( s =~ /:(\ )+[a-zA-Z0-9]/)
      tmp =s.split(": ")
      hhash.store(tmp[0],tmp[1])
    else
    end
  end
end

outputtxt("222",hhash)
