import sys
import csv

def parse_line(line):
    line = line.strip()
    if not line:
        return None
    try:
        url,username,password = line.rsplit(":",2)
        return url,username,password
    except ValueError:
        return None



def lexer_file_to_csv(input_path, output_path):
    with open(input_path, "r", encoding="utf-8", errors="ignore") as infile, open(output_path, "w", newline="", encoding="utf-8") as outfile:
        writer = csv.writer(outfile)
        writer.writerow(["url", "username", "password"])
        for line_number, line in enumerate(infile, start=1):
            tokens = parse_line(line)
            if tokens:
                writer.writerow(tokens)
            else:
                print(f"Skipping malformed line {line_number}: {line.strip()}")

if __name__ == "__main__":
    input_file = str(sys.argv[1])
    output_file = str(sys.argv[2])
    if len(sys.argv) <3:
        print("Usage: python3 logparse.py <inputfile.txt> <outputfile.csv>")
    lexer_file_to_csv(input_file, output_file)


