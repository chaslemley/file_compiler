def compile(in_file, out_file, ancestors = [])
  puts "compiling: #{in_file}, ancestors: #{ancestors}"
  in_file = File.open(in_file, "r")
  out_file = out_file.is_a?(File) ? out_file : File.open(out_file, "w")

  in_file.each do |line|
    if line.start_with?("#include")
      file = line.match(/"(.*)"/)[1]
      raise "Infinite Loop!" if ancestors.include?(file)
      compile(file, out_file, ancestors + [File.basename(in_file)])
    else
      out_file << line
    end
  end
end

compile("a.rec", "out.compiled")
