import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../models/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? editing;
  const ProductFormScreen({super.key, this.editing});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _volumeCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _imgCtrl = TextEditingController();
  String _category = 'Декоративная';
  double _rating = 4.5;

  @override
  void initState() {
    super.initState();
    final p = widget.editing;
    if (p != null) {
      _nameCtrl.text = p.name;
      _brandCtrl.text = p.brand;
      _volumeCtrl.text = p.volume;
      _expCtrl.text = p.expirationDate;
      _imgCtrl.text = p.imageUrl;
      _category = p.category;
      _rating = p.rating;
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<ProductsCubit>();

    final newProduct = Product(
      id: widget.editing?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: _nameCtrl.text.trim(),
      brand: _brandCtrl.text.trim(),
      category: _category,
      volume: _volumeCtrl.text.trim(),
      expirationDate: _expCtrl.text.trim(),
      rating: _rating,
      isFavorite: widget.editing?.isFavorite ?? false,
      imageUrl: _imgCtrl.text.trim().isEmpty
          ? 'https://pcdn.goldapple.ru/p/p/19000197603/imgmain.jpg'
          : _imgCtrl.text.trim(),
    );

    if (widget.editing == null) {
      cubit.addProduct(newProduct);
    } else {
      cubit.updateProduct(newProduct);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(widget.editing == null ? 'Добавление товара' : 'Редактирование'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
              ),
              TextFormField(
                controller: _brandCtrl,
                decoration: const InputDecoration(labelText: 'Бренд'),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: const [
                  DropdownMenuItem(value: 'Декоративная', child: Text('Декоративная')),
                  DropdownMenuItem(value: 'Уходовая', child: Text('Уходовая')),
                  DropdownMenuItem(value: 'Парфюмерия', child: Text('Парфюмерия')),
                ],
                onChanged: (v) => setState(() => _category = v ?? 'Декоративная'),
                decoration: const InputDecoration(labelText: 'Категория'),
              ),
              TextFormField(
                controller: _volumeCtrl,
                decoration: const InputDecoration(labelText: 'Объем'),
              ),
              TextFormField(
                controller: _expCtrl,
                decoration: const InputDecoration(labelText: 'Срок годности'),
              ),
              TextFormField(
                controller: _imgCtrl,
                decoration: const InputDecoration(labelText: 'URL изображения'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
