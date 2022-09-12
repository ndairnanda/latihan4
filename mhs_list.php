<?php
defined('BASEPATH') OR exit('No direct script access allowed');
$this->load->view('dist/_partials/header');
?>
      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>Data Mahasiswa</h1>
            <div class="section-header-breadcrumb">
              <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
              <div class="breadcrumb-item"><a href="#">Modules</a></div>
              <div class="breadcrumb-item">DataTables</div>
            </div>
          </div>

          <div class="section-body">
            

            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>List Data Mahasiswa</h4>
                  </div>
                  <div class="card-body">
                    <a href="<?= base_url()?>/mahasiswa/add" class='btn btn-primary'>Tambah Data</a>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table class="table table-striped" id="table-1">
                        <thead>                                 
                          <tr>
                            <th>ID Mahasiswa</th>
                            <th>Nama Mahasiswa</th>
                            <th>NIM</th>
                            <th>No HP</th>
                            <th>Email</th>
                            <th>Jurusan</th>
                            <th>Foto Profil</th>
                            <th>Alamat</th>
                            <th>Action</th>
                          </tr>
                        </thead>
                        <tbody>                                 
                          <?php foreach ($mahasiswa as $row): ?>
                          <tr>
                            <td><?= $row->id_mhs; ?></td>
                            <td><?= $row->nama; ?></td>
                            <td><?= $row->nim; ?></td>
                            <td><?= $row->no_hp; ?></td>
                            <td><?= $row->email; ?></td>
                            <td><?= $row->jurusan; ?></td>
                            <td>Tidak ada foto profil</td>
                            <td><?= $row->alamat; ?></td>
                            <td>
                              <a href="<?= base_url()?>/mahasiswa/edit/<?= $row->id_mhs; ?>" class='btn btn-warning'>Edit</a>
                              <a href="<?= base_url()?>/mahasiswa/hapus/<?= $row->id_mhs; ?>" class='btn btn-danger'>Hapus</a>
                            </td>
                          </tr>
                          <?php endforeach; ?>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
          </div>
        </section>
      </div>
<?php $this->load->view('dist/_partials/footer'); ?>