




ALTER TABLE [dbo].[Images] ALTER COLUMN path NVARCHAR(MAX);



-- Images
INSERT INTO [dbo].[Images] ([name], [path])
VALUES 
  ('Bolitas de queso 1', 'https://tostydiversion.com/wp-content/uploads/2016/10/producto-bolitas.png'),
  ('Bolitas de queso 2', 'https://s.cornershopapp.com/product-images/2365041.jpg?versionId=EcDZ_Qu1BlDLbUxw7oD7XQv3uJjwoa3c'),
  ('Chocolate 1', 'https://i5.walmartimages.com/asr/64a1314f-3cf0-4f04-8673-8fbfae689317_1.fd9e0128139f6d46c8d3a6cf87b9cc97.jpeg'),
  ('Chocolate 2', 'https://th.bing.com/th/id/R.a106625f68b0d958569730c2fbbff255?rik=%2baHlFVoGfzXCdw&pid=ImgRaw&r=0'),
  ('Gomitas 1', 'https://images.jumpseller.com/store/tu-super-tm/9558553/Dise_o_sin_t_tulo__90_.png?1631459949'),
  ('Gomitas 2', 'https://cdn.shopify.com/s/files/1/0069/6149/6154/products/Trululu-Gomitas-Aros-Fruit-Flavored-Gummies_560x700.jpg?v=1615569076'), 
  ('Fresco Leche 1', 'https://th.bing.com/th/id/R.30ac1279a2945f9b0f51fe9adab5d561?rik=hABkB2PhJt2uvQ&pid=ImgRaw&r=0'),
  ('Fresco Leche 2', 'https://s.cornershopapp.com/product-images/2153040.jpg?versionId=ocOotIKZbZlGj7O1VQ.XhyyEteat4mfQ'),
  ('Rompope 1', 'https://th.bing.com/th/id/OIP.gFUQZKnS-bxn-1h4PF93YAHaHa?rs=1&pid=ImgDetMain'),
  ('Rompope 2', 'https://www.peridomicilio.com/images/detailed/7/7441001613012.jpg'),
  ('Jugo de Naranja 1', 'https://i1.wp.com/nutriciondospinos.com/wp-content/uploads/2019/10/JN100.png?fit=500%2C800&ssl=1'),
  ('Jugo de Naranja 2', 'https://jacofresh.com/wp-content/uploads/2021/04/jacofresh-Jugo-de-Naranja-100-Premium-con-Pulpa-1.8-L-Dos-Pinos-1.jpg'),
  ('Camisa 1', 'https://www.jemrayenergy.com/wp-content/uploads/2020/08/mens-tees-stussy-basic-stc3bcssy-tee-black-1024x1024.jpg'),
  ('Camisa 2', 'https://i.pinimg.com/originals/b0/07/4a/b0074ab81eae1b975795475e836440a1.jpg'),
  ('Pantalon 1', 'https://cdn.shopify.com/s/files/1/0073/1797/9225/products/145855_LodenSilo_700x700.jpg?v=1569853703'),
  ('Pantalon 2', 'https://th.bing.com/th/id/OIP.XLSqIbA1cDfC20G-FMf7NgHaHa?w=600&h=600&rs=1&pid=ImgDetMain'),
  ('Sueter 1', 'https://th.bing.com/th/id/R.1c5443668dd3d11e76373c1f9bf6861a?rik=CaKhV579e5TCeA&riu=http%3a%2f%2fpicture-cdn.wheretoget.it%2fz4e0hw-l-610x610-sweater-nike-nike%2bsb-hoodie-grey.jpg&ehk=hRJNTTvRIR5gFIzPnkyXflT7hW%2bXCh5Y7VRAan1aa4g%3d&risl=&pid=ImgRaw&r=0'),
  ('Sueter 2', 'https://i.pinimg.com/474x/a5/64/3f/a5643f150220c23d92084b1312550aec.jpg'),
  ('Skateboard 1', 'https://th.bing.com/th/id/OIP.TT2ek7czn-pq2HAvfriR9wHaHa?rs=1&pid=ImgDetMain'),
  ('Skateboard 2', 'https://www.nativeskatestore.co.uk/images/toy-machine-skateboards-monster-yellow-complete-skateboard-8-0-p47971-119427_medium.jpg'),
  ('Casco 1', 'https://img.redbull.com/images/c_crop,x_0,y_0,h_2000,w_3000/c_fill,w_1500,h_1000/q_auto,f_auto/redbullcom/2015/08/18/1331742067563_7/il-casco-di-curtis-keene-riflette-le-sue-origini'),
  ('Casco 2', 'https://ae01.alicdn.com/kf/HTB1ZzM.NXXXXXb5XVXXq6xXFXXXA/1pc-ECE-Approved-Thunder-Bull-Motorcycle-Helmets-With-Double-D-Ring-Buckle-Motocross-Capacetes-Red.jpg_640x640.jpg'),
  ('Espinilleras 1', 'https://cdn.shopify.com/s/files/1/0646/4097/products/Espinillera_D-Luxe_580x@2x.jpg?v=1622731345'),
  ('Espinilleras  2', 'https://th.bing.com/th/id/R.225b7a9ca1f2a09b354f841fbb36102a?rik=3Tc1tAkD3D400A&riu=http%3a%2f%2fwww.mma-icons.com%2fimages%2fkuvat%2fbad_boy_pro_series_pro_gel_shin_guard_black02.jpg&ehk=5VPQaMrE%2bJteHr6wiUElS9LofBRU6whfqvmx32uxM0w%3d&risl=&pid=ImgRaw&r=0');

 -- ImagesXProducts
INSERT INTO [dbo].[ImagesXProducts] ([idProduct], [idImage])
VALUES 
  (1, 1),
  (1, 2),
  (2, 1),
  (2, 2),
  (3, 1),
  (3, 2),
  (4, 1),
  (4, 2),
  (5, 1),
  (5, 2),
  (6, 1),
  (6, 2),
  (7, 1),
  (7, 2),
  (8, 1),
  (8, 2),
  (9, 1),
  (9, 2),
  (10, 1),
  (10, 2),
  (11, 1),
  (11, 2),
  (12, 1),
  (12, 2);