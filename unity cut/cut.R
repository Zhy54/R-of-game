# 读取txt文件
txt_file <- "R.txt"
lines <- readLines(txt_file)

# 创建一个空的data frame
output <- data.frame(Key = character(0), Value = character(0), stringsAsFactors = FALSE)

# 遍历每一行，处理注释行和键值对行
for (line in lines) {
  # 如果是空行，插入一行 "BLANK, BLANK"
  if (trimws(line) == "") {
    new_row <- data.frame(Key = "BLANK", Value = "BLANK", stringsAsFactors = FALSE)
  } else {
    # 如果是注释行（以 "//" 开头），将其作为Key，Value为空
    if (substr(line, 1, 2) == "//") {
      new_row <- data.frame(Key = line, Value = "", stringsAsFactors = FALSE)
    } else {
      # 查找等号的位置
      eq_pos <- regexpr("=", line)
      
      if (eq_pos > 0) {
        # 提取等号前后的内容
        key <- substr(line, 1, eq_pos - 1)  # 等号前
        value <- substr(line, eq_pos + 1, nchar(line))  # 等号后
        
        # 构建新的一行
        new_row <- data.frame(Key = key, Value = value, stringsAsFactors = FALSE)
      }
    }
  }
  
  # 将新行加入到输出数据框
  output <- rbind(output, new_row)
}

# 保存为csv文件
write.csv(output, "R.csv", row.names = FALSE)
