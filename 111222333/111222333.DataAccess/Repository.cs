using System;
using System.Collections.Generic;
using 111222333.DTOSharingOfUPSI;

namespace 111222333.SharingOfUPSI
{
    public class Repository
    {
        public List<Model> GetAll()
        {
            // Get all records from database 
            List<Model> records = new List<Model>();
            return records;
        }

        public Model GetById(int id)
        {
            // Get a single record from the database
            Model record = new Model();
            return record;
        }

        public void Insert(Model model)
        {
            // Insert a new record into the database
        }

        public void Update(Model model)
        {
            // Update an existing record in the database
        }

        public void Delete(int id)
        {
            // Delete an existing record from the database
        }
    }
}