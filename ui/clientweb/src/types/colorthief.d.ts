declare module 'colorthief' {
  export default class ColorThief {
    constructor();

    /**
     * Get the dominant color from an image.
     * @param sourceImage - Image element or canvas
     * @param quality - (optional) Default: 10. Lower number means higher quality but slower processing time.
     * @returns Array of [r, g, b] values
     */
    getColor(sourceImage: HTMLImageElement | HTMLCanvasElement, quality?: number): [number, number, number];

    /**
     * Get a palette from an image (array of colors).
     * @param sourceImage - Image element or canvas
     * @param colorCount - (optional) Default: 10. Number of colors to return
     * @param quality - (optional) Default: 10. Lower number means higher quality but slower processing time.
     * @returns Array of arrays of [r, g, b] values
     */
    getPalette(sourceImage: HTMLImageElement | HTMLCanvasElement, colorCount?: number, quality?: number): Array<[number, number, number]>;
  }
}
