<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Mahasiswa extends CI_Controller {

    public function __construct(){
        parent:: __construct();
        $this->load->model('Mahasiswa_model');
    }

	public function index() {
		
        $this->data['mahasiswa'] = $this->Mahasiswa_model->getDataMahasiswa();
        $this->data['title'] = 'Mahasiswa';
		$this->load->view('mahasiswa/mhs_list', $this->data);
	}

    public function add() {
        $this->data['title'] = 'Tambah Data Mahasiswa';
        $this->load->view('mahasiswa/mhs_add', $this->data);
    }

    public function add_save() {
        $data = array(
            'nama' => $this->input->post('nama'),
            'nim' => $this->input->post('nim'),
            'no_hp' => $this->input->post('no_hp'),
            'email' => $this->input->post('email'),
            'jurusan' => $this->input->post('jurusan'),
            'alamat' => $this->input->post('alamat')
        );

        $simpan = $this->Mahasiswa_model->simpanData($data);

        if($simpan){
            redirect('mahasiswa');
        }
    }

    public function edit($id_mhs) {
        $this->data['title'] = 'Edit Data';
        $this->data['mahasiswa'] = $this->Mahasiswa_model->findData($id_mhs);
        $this->load->view('mahasiswa/mhs_edit', $this->data);
    }

    public function edit_save() {
        $data = array(
            'nama' => $this->input->post('nama'),
            'nim' => $this->input->post('nim'),
            'no_hp' => $this->input->post('no_hp'),
            'email' => $this->input->post('email'),
            'jurusan' => $this->input->post('jurusan'),
            'alamat' => $this->input->post('alamat')
        );

        $id_mhs = $this->input->post('id_mhs');

        $update = $this->Mahasiswa_model->updateData($data, $id_mhs);

        if($update){
            redirect('mahasiswa');
        }
    }

    public function hapus($id_mhs){
        $del = $this->Mahasiswa_model->deleteData($id_mhs);
        if($del){
            redirect('mahasiswa');
        }
    }
}
?>