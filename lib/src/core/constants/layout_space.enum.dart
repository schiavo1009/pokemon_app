enum LayoutSpace {
  xxs(size: 4),
  xs(size: 8),
  s(size: 16),
  m(size: 24),
  md(size: 32),
  l(size: 40),
  xl(size: 48);

  final double size;
  const LayoutSpace({required this.size});
}
