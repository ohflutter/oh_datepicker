/// 描述canvas绘制的位置信息
class Descriptor {
  final double x, y, width, height;
  Descriptor(this.x, this.y, this.width, this.height);

  Descriptor get center => Descriptor((x + width) / 2, (y + height) / 2, 0, 0);
}
