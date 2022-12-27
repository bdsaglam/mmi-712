import sys
from pathlib import Path

OUTPUT_DIR = Path('/data')

def main():
    print(sys.argv[-1])
    with open(OUTPUT_DIR / 'out.png', 'w') as f:
        f.write("Hello")
    print("Success")


if __name__ == '__main__':
    main()

