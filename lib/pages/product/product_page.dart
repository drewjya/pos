import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/database/boxes.dart';
import 'package:pos/database/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _price = TextEditingController();
  final _modalPrice = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _modalPrice.dispose();
    _price.dispose();
    _quantity.dispose();
    super.dispose();
  }

  Future addProduct() async {
    Product newProduct = Product(
      idproduct:
          "PR" + _name.text.substring(0, 2) + _price.text.substring(0, 2),
      name: _name.text,
      harga: double.parse(_price.text),
      hargaModal: double.parse(_modalPrice.text),
      stock: int.parse(_quantity.text),
    );
    final box = Boxes.getProduct();
    box.add(newProduct);
  }

  Future deleteAll() async {
    final box = Boxes.getProduct();
    await box.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              deleteAll();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: Boxes.getProduct().listenable(),
        builder: (context, box, _) {
          final product = box.values.toList().cast<Product>();
          if (product.isEmpty) {
            return const Center(
              child: Text(
                'No Product yet!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  color: Colors.amberAccent,
                  child: ListTile(
                    title: Text(product[index].name),
                    subtitle: Text(product[index].harga.toStringAsFixed(2)),
                    trailing: Text(
                      product[index].stock.toString(),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                BuildContext dialogcontext = context;
                return AlertDialog(
                  scrollable: true,
                  title: const Text('Add Product'),
                  content: Builder(builder: (context) {
                    return SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                                validator: (name) =>
                                    name != null && name.isEmpty
                                        ? 'Enter Product Name'
                                        : null,
                              ),
                              TextFormField(
                                controller: _quantity,
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                ),
                                validator: (qty) => qty != null && qty.isEmpty
                                    ? 'Enter Product Quantity'
                                    : null,
                              ),
                              TextFormField(
                                controller: _price,
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                                validator: (price) =>
                                    price != null && price.isEmpty
                                        ? 'Enter Product price'
                                        : null,
                              ),
                              TextFormField(
                                controller: _modalPrice,
                                decoration: const InputDecoration(
                                  labelText: 'Modal Price',
                                ),
                                validator: (modal) =>
                                    modal != null && modal.isEmpty
                                        ? 'Enter Product Modal'
                                        : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        child: SizedBox(
                          width: size.width * 0.5,
                          child: const Center(
                            child: Text("Submit"),
                          ),
                        ),
                        onPressed: () {
                          addProduct();
                          Navigator.pop(dialogcontext);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
