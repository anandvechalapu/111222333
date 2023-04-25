using System;
using System.Collections.Generic;
using 111222333.DTOSharingOfUPSI;

namespace 111222333.SharingOfUPSI
{
    public class Service111222333
    {
        private readonly Repository _repository;

        public Service111222333(Repository repository)
        {
            _repository = repository;
        }

        public List<Model> GetAll()
        {
            return _repository.GetAll();
        }

        public Model GetById(int id)
        {
            return _repository.GetById(id);
        }

        public void Insert(Model model)
        {
            _repository.Insert(model);
        }

        public void Update(Model model)
        {
            _repository.Update(model);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}