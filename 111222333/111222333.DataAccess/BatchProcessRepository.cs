using 111222333.DTO;

namespace 111222333
{
    public class BatchProcessRepository
    {
        private BATCH_PROCESS.BatchProcess _batchProcess;

        public BatchProcessRepository(BATCH_PROCESS.BatchProcess batchProcess)
        {
            _batchProcess = batchProcess;
        }

        public BatchProcess GetById(int id)
        {
            return _batchProcess.Where(bp => bp.Id == id).SingleOrDefault();
        }

        public IEnumerable<BatchProcess> GetAll()
        {
            return _batchProcess.ToList();
        }

        public void Add(BatchProcess batchProcess)
        {
            _batchProcess.Add(batchProcess);
        }

        public void Update(BatchProcess batchProcess)
        {
            _batchProcess.Update(batchProcess);
        }

        public void Delete(int id)
        {
            var batchProcess = GetById(id);
            _batchProcess.Remove(batchProcess);
        }
    }
}