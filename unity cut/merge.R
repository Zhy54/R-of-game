# 设置输入和输出文件路径
input_file <- "R.csv"  # 输入文件路径
output_file <- "R.txt" # 输出文件路径

# 加载CSV数据
data <- read.csv(input_file, stringsAsFactors = FALSE)

# 检查数据结构
# 假设A列是第一列，C列是第三列
if (ncol(data) < 3) {
  stop("数据格式错误：CSV文件应至少包含三列")
}

# 创建一个空的向量用于保存处理后的文本
formatted_lines <- c()

# 遍历每一行，处理空行、注释行以及键值对
for (i in 1:nrow(data)) {
  # 获取当前行的A列和C列的值
  key <- data[i, 1]  # A列
  value <- data[i, 3]  # C列
  
  # 处理空行
  if (is.na(key) && is.na(value)) {
    formatted_lines <- c(formatted_lines, "BLANK=BLANK")
  } else if (startsWith(key, "//")) {
    # 处理注释行，保留原样
    formatted_lines <- c(formatted_lines, paste(key, "", sep = "="))
  } else {
    # 处理正常的键值对行，格式为 A=C
    formatted_lines <- c(formatted_lines, paste(key, value, sep = "="))
  }
}

# 将处理后的行写入输出文件
writeLines(formatted_lines, output_file)

# 提示用户文件生成成功
cat("文件已生成：", output_file, "\n")

