import 'package:flutter/material.dart';
import 'package:pos/database/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> produk = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _name = TextEditingController();
    TextEditingController _quantity = TextEditingController();
    TextEditingController _price = TextEditingController();
    TextEditingController _modalPrice = TextEditingController();

    addProduct() {
      Product newProduct = Product(
        idproduct:
            "PR" + _name.text.substring(0, 2) + _price.text.substring(0, 2),
        name: _name.text,
        harga: double.parse(_price.text),
        hargaModal: double.parse(_modalPrice.text),
        stock: int.parse(_quantity.text),
      );
      produk.add(newProduct);
      _name.clear();
      _price.clear();
      _modalPrice.clear();
      _quantity.clear();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        itemCount: produk.length,
        itemBuilder: (context, index) {
          if (produk.isEmpty) {
            return const Center(
              child: Text(
                'Please Input Your Product!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              ),
            );
          } else {
            Product data = produk[index];
            return Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                  elevation: 1,
                  
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(data.name),
                            Text(data.harga.toString()),
                            Text(
                              data.hargaModal.toString(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.stock.toString(),
                        ),
                      ),
                    ],
                  )),
            );
          }
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
                              ),
                              TextFormField(
                                controller: _quantity,
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                ),
                              ),
                              TextFormField(
                                controller: _price,
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                              ),
                              TextFormField(
                                controller: _modalPrice,
                                decoration: const InputDecoration(
                                  labelText: 'Modal Price',
                                ),
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
