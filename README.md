Must have wannacri, FFMPEG and mai2dat to encrypt it.

mai2dat link: https://github.com/0x24a/mai2dat

To use it, you need to set INPUT to where your uncompressed .dat files are located or the .dat files themselves if you only want to compress one file. 

WORK is where you can find the decrypted and compressed MVs.

OUTPUT is where the encrypted compressed files are.

DIRECTORY is where you put your mai2dat directory.

KEY is the decryption key.

CPU and THREADS is basically setting how many cores or threads you want to use to process it. 

(The more CPU and THREADS the faster it'll compress but lower quality, the less CPU and THREADS the more the quality but slower compression)

INTEL GPUs only work as almost none of the other manufacturers support the VP9 codex.

If you have an igpu thats from INTEL, you need to activate the igpu in the bios since it will likely be deactivated if you have a dedicated GPU.

As of now 28th of June 2026 the newest version has about 55gb-58gb of MV, it is highly recommended that you have 3/5 more than the uncompressed data so if it is 58gb then you should have 92.8gb of free storage, more is recommended.

After compressing everything, delete all your temp files since there will be a lot of them.

Any questions please DM me in Discord @Shockwave1824
