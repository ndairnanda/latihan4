<?php
defined('BASEPATH') OR exit('Not allowed access');

class Mahasiswa_model extends CI_Model{

    public function getDataMahasiswa(){
        $data = $this->db->get('mahasiswa')->result();
        return $data;
    }

    public function simpanData($data){
        $this->db->insert('mahasiswa',$data);
        return $this;
    }

    public function findData($id_mhs){
        $this->db->where('id_mhs',$id_mhs);
        $data = $this->db->get('mahasiswa')->row();
        return $data;
    }

    public function updateData($data,$id_mhs){
        $this->db->where('id_mhs',$id_mhs);
        $this->db->update('mahasiswa',$data);
        return $this;
    }

    public function deleteData($id_mhs){
        $this->db->where('id_mhs',$id_mhs);
        $this->db->delete('mahasiswa');
        return $this;
    }
}
?>