import argparse
import PIL.Image
import PIL.ImageDraw
import numpy


def encodeGfxTile(img, x, y):
    aa = []
    bb = []
    for py in range(8):
        a = 0
        b = 0
        for px in range(8):
            pix = img.getpixel((x + px, y + py))
            if pix & 1:
                a |= 0x80 >> px
            if pix & 2:
                b |= 0x80 >> px
        aa.append(a)
        bb.append(b)
    return aa, bb


def encodeGfxStep1(img, x, w, h):
    aaa = []
    bbb = []
    for ty in range(h // 8):
        for tx in range(w // 8):
            aa, bb = encodeGfxTile(img, x + tx*8, ty*8)
            aaa += aa
            bbb += bb
    return aaa, bbb


def encodeGfxBlock(data, block_size_shift):
    block_size = 8 << block_size_shift
    result = [block_size_shift]
    for n in range(0, len(data), block_size):
        freq = {}
        for m in range(block_size):
            d = data[n + m]
            freq[d] = freq.get(d, 0) + 1
        fill = max([(b, a) for a, b in freq.items()])[1]
        bitmasks = [0] * (block_size // 8)
        extra = []
        for m in range(block_size):
            d = data[n + m]
            if d != fill:
                extra.append(d)
                bitmasks[m//8] |= 0x80 >> (m & 7)
        result.append(fill)
        result += bitmasks
        result += extra
    return result

def encodeGfxStep2(data):
    best_size = len(data) * 2
    best = None
    for block_size_shift in [0, 1, 2, 3]:
        result = encodeGfxBlock(data, block_size_shift)
        if len(result) < best_size:
            best_size = len(result)
            best = result
    return best

widths = [
    4, 8, 4, 4,
    6, 6, 6, 6,
    6, 6, 16, 4,
    4, 8, 4, 6,
    6, 8,
]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("rom", type=str)
    parser.add_argument("--input", type=str, required=True)
    args = parser.parse_args()

    data = bytearray(open(args.rom, "rb").read())
    
    img = PIL.Image.open(args.input)
    ptr_addr = 0x0B * 0x4000 + 0x03E4
    data_addr = 0x4000
    data_bank = 0x0D
    #data_bank = 0x03
    
    def store(a):
        global data_addr
        global ptr_addr
        data[ptr_addr] = data_addr & 0xFF
        data[ptr_addr+1] = data_addr >> 8
        ptr_addr += 2
        addr = data_bank*0x4000+data_addr-0x4000
        data[addr:addr+len(a)] = a
        data_addr += len(a)

    x = 0
    for n in range(len(widths)):
        w = widths[n] * 8
        h = 256
        while img.getpixel((x, h-1)) == 4:
            h -= 1
        a, b = encodeGfxStep1(img, x, w, h)
        a = encodeGfxStep2(a)
        b = encodeGfxStep2(b)

        if n == 0x0B:
            data[ptr_addr] = data_addr & 0xFF
            data[ptr_addr+1] = data_addr >> 8
            ptr_addr += 2
            data[ptr_addr] = 0
            data[ptr_addr+1] = 0
            ptr_addr += 2
            data_addr = 0x4000
            data_bank += 1
        
        store(a)
        store(b)
        
        x += w
    open(args.rom, "wb").write(data)
