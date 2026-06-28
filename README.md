Must have wannacri, FFMPEG and mai2dat to encrypt it.

mai2dat link: https://github.com/0x24a/mai2dat

To use it, you need to set INPUT to where your uncompressed .dat files are located or the .dat files themselves if you only want to compress one file. 

Work is where you can find the decrypted and compressed MVs.

OUTPUT is where the encrypted compressed files are.

DIRECTORY is where you put your mai2dat directory.

KEY is the decryption key.

CPU and THREADS is basically setting how many cores or threads you want to use to process it. 

(The more CPU and THREADS the faster it'll compress but lower quality, the less CPU and THREADS the more the quality but slower compression)

INTEL GPUs only work as almost none of the other manufacturers support the VP9 codex.

If you have an igpu thats from INTEL, you need to activate the igpu in the bios since it will likely be deactivated if you have a dedicated GPU.

Any questions please DM me in Discord @Shockwave1824
