require "fileutils"

#version 0.3r

$name = "hogehoge"

mainmenu = ["PDFを抽出しリネームする","フォルダを選択し開くorファイルをコピー","PDFを開く(必ず閉じること)"," PDFを上下回転させる","履歴"]

def menu(menu_value)
	i = 1
	menu_value.each do |value|
		print "[#{i}] #{value} "
		i += 1
	end
	puts ""
end

def history_write(command)
	time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
	history_path = 'hogehoge_path'
	File.open(history_path,"a") do |f|
		f.write "#{command} #{time} #{$name}\n"
	end
end

def histroy_read
	history_path = 'hogehoge_path'
	File.open(history_path,"r") do |f|
		print f.read
	end
end

def pdflist
	pdf = Dir.glob("img*.pdf")
	puts pdf
	puts("PDFのファイル名を入力してください")
	puts "数字入力で候補を自動選択"
	i = 0
	pdf.each do |list|
		print "[#{i}]" + list.to_s
		i += 1
	end
	puts ""
	input = gets.chomp.to_i
	pdfname = pdf[input].to_s
	system("start #{pdfname}")
	return pdfname
end

def pdflist2
	pdf = Dir.glob("[0-9]*.pdf")
	puts pdf
	puts("PDFのファイル名を入力してください")
	puts "数字入力で候補を自動選択"
	i = 0
	pdf.each do |list|
		print "[#{i}]" + list.to_s
		i += 1
	end
	puts ""
	input = gets.chomp.to_i
	pdfname = pdf[input].to_s
	return pdfname
end


def pagerange
	puts("抜き取りたいページ数を指定してください ex:2-5");
	page = gets.chomp
	return page
end

def outputname
	puts("出力したいファイル名を入力してください");
	output = gets.chomp
	return output
end

def renamepdf(pdfopen,page,output)
	command = "pdftk " + pdfopen.to_s + " cat " + page.to_s +  " output " + output.to_s 
	puts command.to_s
	history_write(command)
	system "#{command}"
end

def foldernnumber
	puts "フォルダを選択してください"
	input = gets.chomp.to_i
	return input
end

def define_folderpath
	puts "PDFデータのフォルダ選択補助スクリプトです"
	puts "選択したいフォルダに対応した型番を入力してください"
	puts "[1] AAA_BB1 [2] AAA_BB2 [3] AAA_B3 [4] AAA_B4
[5] AAA_B5 [6] AAA_B6 [7] AAA_B7"
	input = gets.chomp.to_i


	case input
	when 1
		puts "[1]CategoryA [2]CategoryB [3]CategoryC"
		input2 = foldernumber()	
		case input2
		when 1
			path = 'hogehoge_path'
		when 2
			path = 'hogehoge_path'
		when 3
			path = 'hogehoge_path'
		else
		end

	when 2
		puts "[1]CategoryA [2]CategoryB [3]CategoryC"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		when 2
			path = 'hogehoge_path'
		when 3
			path = 'hogehoge_path'
		else
		end

	when 3
		puts "[1]CategoryA"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		else
		end
	when 4
		puts "[1]CategoryA [2]CategoryB [3]CategoryC"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		when 2
			path = 'hogehoge_path'
		when 3
			path = 'hogehoge_path'
		else
		end

	when 5
		puts "[1]CategoryA [2]CategoryB [3]CategoryC"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		when 2
			path = 'hogehoge_path'
		when 3
			path = 'hogehoge_path'
		else
		end
	when 6
		puts "[1]CategoryA [2]CategoryB [3]CategoryC"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		when 
			path = 'hogehoge_path'
		when 3
			path = 'hogehoge_path'
		else
		end
	when 7
		puts "[1]某PDFデータ"
		input2 = foldernumber()
		case input2
		when 1
			path = 'hogehoge_path'
		else
		end
	else
	end
	puts path
	return path

end

def folderopen(path)
	system("start #{path}")
end

def pickup_number3(pdfname)
	pdfname = pdfname.to_s
	puts pdfname.to_s
	puts "ファイルの書式は? [0]自動判別 [1]前方記述型 xxx123_xxxx.pdf [2]後方記述型xxxx123LL.pdf [3]3桁を自分で入力する"
	input = gets.chomp.to_i
	case input
	when 0
		if ( /_/ =~ pdfname)
			puts "前方記述型と判断します"
			/[0-9]+.*[0-9]+_/ =~ pdfname 
			temp = $&
				numbers3 = temp[-4,3]  #$&はマッチした文字列
		else
			puts "後方記述型と判断します"
			/[0-9]+.*[0-9]+/ =~ pdfname 
			temp = $&
				numbers3 = temp[-3,3]  
		end
		p numbers3
		return numbers3
	when 1
		/[0-9]+.*[0-9]+_/ =~ pdfname 
		temp = $&
			numbers3 = temp[-4,3]  
		p numbers3
		return numbers3
	when 2
		/[0-9]+.*[0-9]+/ =~ pdfname 
		temp = $&
			numbers3 = temp[-3,3]  
		p numbers3
		return numbers3
	when 3
		numbers3 = gets.chomp.to_i
		if (numbers3.to_s.size != 3)
			puts "入力エラー"
			pickup_number3(pdfname)
		end
		return numbers3
	else
		exit
	end
end

def define_foldernumber(num)  #3桁を送ってもらう
	num3 = num.to_i
	if (num3 % 10  == 0) #170,180,190...
		minrange = num3-9 #161
		maxrange = num3   #170   #161-170
	else
		num3 = (num3/10)*10 #165 -> 160
		minrange = num3+1 #161
		maxrange = num3+10 #170
	end

	foldername = "#" + minrange.to_s + "～" + maxrange.to_s
	puts minrange.to_s + "～" +  maxrange.to_s + "にてマッチ"
	return foldername
end

def sendtopath(pdfname,path,foldername)
	folderfullpath = path.to_s + "/" + foldername.to_s
	unless FileTest.exist?(folderfullpath)
		FileUtils.mkdir_p(folderfullpath)
		puts "フォルダ新設→ #{folderfullpath}"
	end
	fullpath = path.to_s + "/" + foldername.to_s + "/" + pdfname.to_s
	if File.exist?(fullpath) then
		puts "!!!!!!!!既にファイルがあるのでコピーできません!!!!!!!1"
	else
		puts fullpath.to_s + "へコピーしてもよいですか[y/n]"
		x = gets.chomp
		if (x != "y" ) 
			exit
		end
		FileUtils.install(pdfname,fullpath, {:verbose => true}) 
		history_write(fullpath.to_s)
		puts "確認用にフォルダを開きますか？[y/n]"
		check = gets.chomp
		if (check == "y" )
			system("start #{folderfullpath}")
		end
	end
end

def pdf_rename
	pdfname = pdflist() #PDFリスト収得
	page = pagerange()  #PDF加工範囲収得
	output = outputname()  #出力ファイル名
	renamepdf(pdfname,page,output)  #処理実行
end

def folder_control
	puts "[1]フォルダを開く [2]フォルダにファイルをコピー [999]終了"
	input = gets.chomp.to_i
	path = define_folderpath()
	case input
	when 1
		folderopen(path)
	when 2
		while true
			pdfname = pdflist2()
			number3 = pickup_number3(pdfname)
			foldernum = define_foldernumber(number3)
			sendtopath(pdfname,path,foldernum)
			puts "同じ設定で繰り返しますか？[y/n]"
			myloop = gets.chomp
			break if myloop == "y"
		end
	when 999
		exit
	else
	end
end

while true
	puts "電子データ化支援スクリプトです(ver0.3)"
	menu(mainmenu)
	puts "[999]終了"
	input = gets.chomp.to_i
	case input
	when 1 #PDF抽出後リネーム
		pdf_rename()
	when 2 #フォルダ操作
		folder_control()
	when 3 #PDFを開く
		pdfname = pdflist2
		system("start #{pdfname}")
	when 4 #PDFの反転
		pdfname = pdflist2
		system("start pdftk #{pdfname} cat 1-endS output img-#{pdfname}")
		puts "img-img...pdfとついたものが出力になります"
	when 5 #履歴
		histroy_read()
	when 100
		puts "隠しコマンド、MS-DOSコマンド実行"
		input = gets.chomp
		system(input)
	when 999
		break
	else
	end

end
