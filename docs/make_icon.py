"""Draws a simple meter + lightning launcher icon (no logo) at Android sizes."""
import math, sys
from PIL import Image, ImageDraw

def draw(size):
    S = 1024
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # Rounded blue background.
    d.rounded_rectangle([0, 0, S - 1, S - 1], radius=220, fill=(13, 71, 161, 255))
    # Meter dial (white circle with dark ring).
    cx, cy, r = S // 2, S // 2 + 30, 360
    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(255, 255, 255, 255))
    d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(25, 40, 80, 255), width=34)
    # Dial ticks on the upper arc.
    for i in range(9):
        a = math.radians(200 + i * 17.5)
        x1, y1 = cx + (r - 50) * math.cos(a), cy + (r - 50) * math.sin(a)
        x2, y2 = cx + (r - 110) * math.cos(a), cy + (r - 110) * math.sin(a)
        d.line([x1, y1, x2, y2], fill=(25, 40, 80, 255), width=22)
    # Lightning bolt in amber.
    bolt = [(560, 270), (390, 560), (500, 560), (440, 800), (640, 480), (525, 480), (600, 270)]
    d.polygon(bolt, fill=(255, 179, 0, 255), outline=(120, 70, 0, 255))
    return img.resize((size, size), Image.LANCZOS)

res = sys.argv[1]
for folder, px in {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}.items():
    draw(px).save(f"{res}/mipmap-{folder}/ic_launcher.png")
draw(512).save(sys.argv[2])
