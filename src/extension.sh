#!/bin/bash

# ············
# .   HELP   .
# ............

ext::usage()
{
    local argc=$1

    if test $argc -ne 1
    then
        echo "Usage: $0 <file>"
        exit 1
    fi
}



ext::variables()
{
    unset ext
    unset desc
    unset header
}

ext::hexparser()
{
    local len=16
    local program=$1
    header=$(head -c $len $program | xxd -ps -u)
}

ext::magicnumbers()
{
    # https://en.wikipedia.org/wiki/List_of_file_signatures

    case $header in
    # 30 bytes
        53494D504C4520203D202020202020202020202020202020202020202054*)
			ext="fits"
			desc="Flexible Image Transport System (FITS)"
			;;
    # 29 bytes
    # 28 bytes
    # 27 bytes
    # 26 bytes
    # 25 bytes
    # 24 bytes
        FFD8FFDBFFD8FFE000104A4649460001FFD8FFEEFFD8FFE1*)
            ext="jpg,jpeg"
            desc="JPEG raw or in the JFIF or Exif file format"
            ;;
    # 23 bytes
    # 22 bytes
        05070000424F424F0507000000000000000000000001*)
			ext="cwk"
			desc="AppleWorks 5 document"
			;;
        0607E100424F424F0607E10000000000000000000001*)
			ext="cwk"
			desc="AppleWorks 6 document"
			;;
    # 21 bytes
    # 20 bytes
    # 19 bytes
    # 18 bytes
    # 17 bytes
    # 16 bytes
        3026B2758E66CF11A6D900AA0062CE6C*)
			ext="asf,wma,wmv"
			desc="Advanced Systems Format"
			;;
        53514C69746520666F726D6174203300*)
            ext="sqlitedb,sqlite,db"
            desc="SQLite Database"
            ;;
        626F6F6B000000006D61726B00000000*)
			ext="alias"
			desc="macOS file Alias (Symbolic link)"
			;;
    # 15 bytes
    # 14 bytes
        5B5A6F6E655472616E736665725D*)
			ext="Identifier"
			desc="Microsoft Zone Identifier for URL Security Zones"
			;;
    # 13 bytes
        4552020000008B455202000000*)
			ext="toast"
			desc="Roxio Toast disc image file, also some .dmg-files begin with same bytes"
			;;
    # 12 bytes
        20020162A01EAB0702000000*)
			ext="tde"
			desc="Tableau Datasource"
			;;
        4241434B4D494B454449534B*)
            ext="bac"
            desc="File or tape containing a backup done with AmiBack on an Amiga. It typically is paired with an index file (idx) with the table of contents."
            ;;
        474946383761474946383961*)
            ext="gif"
            desc="Image file encoded in the Graphics Interchange Format (GIF)"
            ;;
    # 11 bytes
    # 10 bytes
        49492A00100000004352*)
            ext="cr2"
            desc="Canon RAW Format Version 2[8] Canon's RAW format is based on the TIFF file format[9]"
            ;;
    # 9 bytes
        000001BA47000001B3*)
			ext="mpg,,mpeg"
			desc="MPEG Program Stream, MPEG Transport Stream, MPEG-1 video and MPEG-2 video (MPEG-1 Part 2 and MPEG-2 Part 2)"
			;;
    # 8 bytes
        2453444930303031*)
			ext=""
			desc="System Deployment Image, a disk image format used by Microsoft"
			;;
        504B0304504B0506*)
			ext="zip,aar,apk,docx,epub,ipa,jar,kmz,maff,odp,ods,odt,pk3,pk4,pptx,usdz,vsdx,xlsx,xpi"
			desc="Empty zip file format and formats based on it, such as EPUB, JAR, ODF, OOXML"
			;;
        524E4301524E4302*)
            ext=""
            desc="Compressed file using Rob Northen Compression (version 1 and 2) algorithm"
            ;;
        5265636569766564*)
			ext="eml"
			desc="Email Message var5"
			;;
        89504E470D0A1A0A*)
			ext="png"
			desc="Image encoded in the Portable Network Graphics format"
			;;
    # 7 bytes
        213C617263683E*)
			ext="deb"
			desc="linux deb file"
			;;
        526172211A0700*)
			ext="rar"
			desc="RAR archive version 1.50 onwards"
			;;
    # 6 bytes
        435753465753*)
			ext="swf"
			desc="Flash File Format"
			;;
        7801789C78DA*)
			ext="zlib"
			desc="No Compression/low, Default Compression, Best Compression"
			;;
        7B5C72746631*)
			ext="rtf"
			desc="Rich Text Format"
			;;
    # 5 bytes
        255044462d*)
			ext="pdf"
			desc="PDF document"
			;;
    # 4 bytes
        00000100*)
            ext="ico"
            desc="Computer icon encoded in ICO file format"
            ;;
        00010000*)
            ext=""
            desc="Palm Desktop Data File (Access format)"
            ;;
        00014244*)
            ext="dba"
            desc="Palm Desktop To Do Archive"
            ;;
        00014454*)
            ext="tda"
            desc="Palm Desktop Calendar Archive"
            ;;
        0A0D0D0A*)
            ext="pcapng"
            desc="PCAP Next Generation Dump File Format"
            ;;
        25215053*)
			ext="ps"
			desc="PostScript document"
			;;
        38425053*)
			ext="psd"
			desc="Photoshop Document file, Adobe Photoshop's native file format"
			;;
        425047FB*)
			ext="bpg"
			desc="Better Portable Graphics format"
			;;
        49492A00*)
            ext="tif,tiff"
            desc="Tagged Image File Format"
            ;;
        494E4458*)
			ext="idx"
			desc="Index file to a file or tape containing a backup done with AmiBack on an Amiga."
			;;
        4C5A4950*)
			ext="lz"
			desc="lzip compressed file"
			;;
        4F676753*)
			ext="ogg,oga,ogv"
			desc="Ogg, an open source media container format"
			;;
        504B0708*)
			ext="zip,aar,apk,docx,epub,ipa,jar,kmz,maff,odp,ods,odt,pk3,pk4,pptx,usdz,vsdx,xlsx,xpi"
			desc="Spanned zip file format and formats based on it, such as EPUB, JAR, ODF, OOXML"
			;;
        52494646*)
			ext="wav,avi"
			desc="Waveform Audio File Format or Audio Video Interleave Video Format"
			;;
        53503031*)
            ext="bin"
            desc="Amazon Kindle Update Package"
            ;;
        54444546*)
            ext="TDEF"
            desc="Telegram Desktop Encrypted File"
            ;;
        54444624*)
            ext="TDF$"
            desc="Telegram Desktop File"
            ;;
        58504453*)
			ext="dpx"
			desc="SMPTE DPX image"
			;;
		762F3101*)
			ext="exr"
			desc="OpenEXR image"
			;;
        7F454C46*)
			ext=""
			desc="Executable and Linkable Format"
			;;
        802A5FD7*)
	        ext="cin"
	        desc="Kodak Cineon image"
	        ;;
        A1B2C3D4*)
            ext="dba"
            desc="Palm Desktop Calendar Archive"
            ;;
        BEBAFECA*)
            ext="pcap"
            desc="Libpcap File Format"
            ;;
        CAFEBABE*)
			ext="class"
			desc="Java class file, Mach-O Fat Binary"
			;;
        CEFAEDFE*)
			ext=""
			desc="Mach-O binary (reverse byte ordering scheme, 32-bit)"
			;;
        CFFAEDFE*)
			ext=""
			desc="Mach-O binary (reverse byte ordering scheme, 64-bit)"
			;;
        D4C3B2A1*)
            ext="pcap"
            desc="Libpcap File Format"
            ;;
        EDABEEDB*)
            ext="rpm"
            desc="RedHat Packet Manager (RPM) package"
            ;;
        FEEDFACE*)
			ext=""
			desc="Mach-O binary (32-bit)"
			;;
        FEEDFACF*)
			ext=""
			desc="Mach-O binary (64-bit)"
			;;
        FEEDFEED*)
			ext=""
			desc="JKS JavakeyStore"
			;;
        FFFE0000*)
			ext=""
			desc="Byte-order mark for text file encoded in little-endian 32-bit Unicode Transfer Format"
			;;
        # 3 bytes
        425A68*)
            ext="bz2"
            desc="Compressed file using Bzip2 algorithm"
            ;;
        4F5243*)
			ext="orc"
			desc="Apache ORC (Optimized Row Columnar) file format"
			;;
        785634*)
			ext="pbt,pdt,pea,peb,pet,pgt,pict,pjt,pkt,pmt"
			desc="PhotoCap Template"
			;;
        CF8401*)
			ext="lep"
			desc="Lepton compressed JPEG image"
			;;
        EFBBBF*)
			ext=""
			desc="UTF-8 encoded Unicode byte order mark, commonly seen in text files."
			;;
        # 2 bytes
        1F8B*)
			ext="gz,tar.gz"
			desc="GZIP compressed file"
			;;
        1F9D*)
            ext="z,tar.z"
            desc="compressed file (often tar zip) using Lempel-Ziv-Welch algorithm"
            ;;
        1FA0*)
            ext="z,tar.z"
            desc="Compressed file (often tar zip) using LZH algorithm"
            ;;
        2321*)
            ext=""
            desc="Script or data beginning with the shebang (#!)"
            ;;
        424D*)
			ext="bmp,dib"
			desc="BMP file, a bitmap format used mostly in the Windows world"
			;;
        3082*)
			ext="der"
			desc="DER encoded X.509 certificate"
			;;
        4D5A*)
			ext="exe,dll"
			desc="DOS MZ executable file format and its descendants (including NE and PE)"
			;;
        FFFB*)
			ext="mp3"
			desc="MPEG-1 Layer 3 file without an ID3 tag or with an ID3v1 tag (which's appended at the end of the file)"
			;;
        FFFE*)
			ext=""
			desc="Byte-order mark for text file encoded in little-endian 16-bit Unicode Transfer Format"
			;;
        # 1 bytes
        00*)
            ext="PIC,PIF,SEA,YTR"
            desc="IBM Storyboard bitmap file or Windows Program Information File or Mac Stuffit Self-Extracting Archive or IRIS OCR data file"
            ;;
        47*)
			ext="ts,tsv,tsa"
			desc="MPEG Transport Stream (MPEG-2 Part 1)"
			;;
        # Default
        *)
            ext="raw"
            desc="Raw data file"
            ;; 
    esac
}

ext::output()
{
    echo "[Extension]   : $ext"
    echo "[Description] : $desc"
}

ext::main()
{
    ext::usage          $#
    ext::variables
    ext::hexparser      $1
    ext::magicnumbers
    ext::output
}
ext::main $@



        








