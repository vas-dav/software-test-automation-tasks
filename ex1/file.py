import os

def file_exists(file):
    return os.path.isfile(file)

def get_line_from_file(file):
    return open(file).readline().rstrip()

def lines_in_file(file):
    return sum(1 for line in open(file))